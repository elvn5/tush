import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';

class AddDreamModal extends HookWidget {
  const AddDreamModal({super.key});

  /// Maps simple locale codes to full speech recognition locale IDs.
  /// The speech_to_text package requires full locale IDs (e.g., 'ru-RU')
  /// for proper language recognition.
  static String _getSpeechLocaleId(String localeTag) {
    const localeMapping = {'ru': 'ru-RU', 'en': 'en-US', 'ky': 'ky-KG'};
    return localeMapping[localeTag] ?? localeTag;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final speechToText = useMemoized(() => stt.SpeechToText());
    final isListening = useState(false);
    final speechAvailable = useState<bool?>(null); // null = not initialized yet
    final isInitializing = useState(false);

    Future<bool> initializeSpeech() async {
      if (speechAvailable.value != null) {
        return speechAvailable.value!;
      }

      isInitializing.value = true;
      try {
        final available = await speechToText.initialize(
          onError: (error) {
            debugPrint('Speech recognition error: ${error.errorMsg}');
            isListening.value = false;
          },
          onStatus: (status) {
            debugPrint('Speech recognition status: $status');
            if (status == 'notListening' || status == 'done') {
              isListening.value = false;
            }
          },
        );
        speechAvailable.value = available;
        if (!available) {
          debugPrint('Speech recognition not available on this device');
        }
        return available;
      } catch (e) {
        debugPrint('Speech initialization error: $e');
        speechAvailable.value = false;
        return false;
      } finally {
        isInitializing.value = false;
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: BlocListener<DreamsBloc, DreamsState>(
        listener: (context, state) {
          state.mapOrNull(
            loaded: (state) {
              if (state.isAdded) {
                Navigator.of(context).pop();
              }
            },
          );
        },
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'new_dream'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              AppFormBuilderTextField(
                name: 'dream',
                label: 'your_dream'.tr(),
                hint: 'describe_your_dream'.tr(),
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              _buildSpeechRecordButton(
                context: context,
                speechToText: speechToText,
                isListening: isListening,
                isInitializing: isInitializing,
                initializeSpeech: initializeSpeech,
                formKey: formKey,
              ),
              const SizedBox(height: 16),
              BlocBuilder<DreamsBloc, DreamsState>(
                builder: (context, state) {
                  return AppButton(
                    text: 'save_dream'.tr(),
                    isLoading: state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final dreamText =
                            formKey.currentState?.value['dream'] as String?;
                        if (dreamText != null && dreamText.isNotEmpty) {
                          context.read<DreamsBloc>().add(
                            DreamsEvent.add(dreamText),
                          );
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpeechRecordButton({
    required BuildContext context,
    required stt.SpeechToText speechToText,
    required ValueNotifier<bool> isListening,
    required ValueNotifier<bool> isInitializing,
    required Future<bool> Function() initializeSpeech,
    required GlobalKey<FormBuilderState> formKey,
  }) {
    return GestureDetector(
      onTap: () async {
        if (isInitializing.value) return;

        // Initialize on first tap
        final available = await initializeSpeech();

        if (!available) {
          Fluttertoast.showToast(msg: 'speech_not_available'.tr());
          return;
        }

        if (isListening.value) {
          await speechToText.stop();
          isListening.value = false;
        } else {
          isListening.value = true;
          // Map simple locale codes to full speech recognition locale IDs
          final localeTag = context.locale.toLanguageTag();
          final speechLocaleId = _getSpeechLocaleId(localeTag);

          await speechToText.listen(
            onResult: (result) {
              final currentText =
                  formKey.currentState?.fields['dream']?.value as String? ?? '';

              // Only update with final results or significant changes
              if (result.finalResult) {
                final newText = currentText.isEmpty
                    ? result.recognizedWords
                    : '$currentText ${result.recognizedWords}';
                formKey.currentState?.fields['dream']?.didChange(newText);
              }
            },
            localeId: speechLocaleId,
            listenFor: const Duration(seconds: 30),
            pauseFor: const Duration(seconds: 5),
            partialResults: false,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isListening.value
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isInitializing.value)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            else
              Icon(
                isListening.value ? Icons.stop : Icons.mic,
                color: isListening.value
                    ? Theme.of(context).colorScheme.onErrorContainer
                    : Theme.of(context).colorScheme.primary,
              ),
            const SizedBox(width: 8),
            Text(
              isListening.value ? 'listening'.tr() : 'tap_to_record'.tr(),
              style: TextStyle(
                color: isListening.value
                    ? Theme.of(context).colorScheme.onErrorContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
