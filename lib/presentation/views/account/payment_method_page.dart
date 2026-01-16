import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:url_launcher/url_launcher.dart';

enum PaymentMethod { momo, vnpay, zalopay, bankingQr }

class PaymentMethodPage extends StatefulWidget {
  final SubscriptionPlan plan;

  const PaymentMethodPage({super.key, required this.plan});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  PaymentMethod? _selectedPaymentMethod;
  bool _isProcessing = false;

  final List<PaymentMethodOption> _paymentOptions = [
    PaymentMethodOption(
      method: PaymentMethod.momo,
      name: 'Momo',
      description: 'Pay with Momo e-wallet',
      logoPath: "assets/logo/momo.png",
      color: Colors.pink,
    ),
    PaymentMethodOption(
      method: PaymentMethod.vnpay,
      name: 'VNPay',
      description: 'Pay with VNPay gateway',
      logoPath: "assets/logo/vnpay.png",
      color: Colors.blue,
    ),
    PaymentMethodOption(
      method: PaymentMethod.zalopay,
      name: 'ZaloPay',
      description: 'Pay with ZaloPay e-wallet',
      logoPath: "assets/logo/zalopay.png",
      color: Colors.orange,
    ),
    PaymentMethodOption(
      method: PaymentMethod.bankingQr,
      name: 'Banking QR',
      description: 'Pay with your bank QR code',
      logoPath: "assets/logo/banking.png",
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Select Payment Method'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan Summary
                    _buildPlanSummary(colorScheme),
                    const SizedBox(height: 24),

                    // Payment Methods Title
                    Text(
                      'Choose Payment Method',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Payment Method Options
                    ..._paymentOptions.map(
                      (option) => _buildPaymentMethodTile(option, colorScheme),
                    ),
                  ],
                ),
              ),
            ),

            // Payment Button
            _buildPaymentButton(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSummary(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: AppBorderRadius.large,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/ic_upgrade.svg',
            width: 48,
            height: 48,
            colorFilter: ColorFilter.mode(Colors.yellowAccent, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.plan.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.plan.price}${widget.plan.billingPeriod}',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onPrimary.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(
    PaymentMethodOption option,
    ColorScheme colorScheme,
  ) {
    final isSelected = _selectedPaymentMethod == option.method;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = option.method;
          });
        },
        borderRadius: AppBorderRadius.large,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant.withAlpha(150),
              width: isSelected ? 2 : 1.5,
            ),
            color: isSelected
                ? colorScheme.primaryContainer.withAlpha(50)
                : colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: option.color.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),

                  child: Container(
                    color: Colors.white,
                    child: Image.asset(option.logoPath, width: 34, height: 34),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      option.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withAlpha(140),
                      ),
                    ),
                  ],
                ),
              ),
              Radio<PaymentMethod>(
                value: option.method,
                groupValue: _selectedPaymentMethod,
                onChanged: (PaymentMethod? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            disabledBackgroundColor: colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.large),
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: _selectedPaymentMethod == null || _isProcessing
              ? null
              : _processPayment,
          child: _isProcessing
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    color: _selectedPaymentMethod == null
                        ? colorScheme.onSurface.withAlpha(100)
                        : colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (_selectedPaymentMethod == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate payment processing delay
      await Future.delayed(const Duration(milliseconds: 500));

      switch (_selectedPaymentMethod!) {
        case PaymentMethod.momo:
          await _openMomoApp();
          break;
        case PaymentMethod.vnpay:
          await _openVNPayApp();
          break;
        case PaymentMethod.zalopay:
          await _openZaloPayApp();
          break;
        case PaymentMethod.bankingQr:
          await _openBankingQr();
          break;
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to open payment app: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _openMomoApp() async {
    // Momo deep link format
    // You'll need to replace these with actual payment parameters from your backend
    final momoUrl = Uri.parse('momo://app');

    // Alternative web URL if app is not installed
    final momoWebUrl = Uri.parse('https://momo.vn');

    try {
      if (await canLaunchUrl(momoUrl)) {
        await launchUrl(momoUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to web if app not installed
        if (await canLaunchUrl(momoWebUrl)) {
          await launchUrl(momoWebUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not open Momo';
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Momo app is not installed. Please install it first.');
      }
    }
  }

  Future<void> _openVNPayApp() async {
    // VNPay deep link format
    final vnpayUrl = Uri.parse('vnpay://app');

    // Alternative web URL
    final vnpayWebUrl = Uri.parse('https://vnpay.vn');

    try {
      if (await canLaunchUrl(vnpayUrl)) {
        await launchUrl(vnpayUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to web if app not installed
        if (await canLaunchUrl(vnpayWebUrl)) {
          await launchUrl(vnpayWebUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not open VNPay';
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(
          'VNPay app is not installed. Please install it first.',
        );
      }
    }
  }

  Future<void> _openZaloPayApp() async {
    // ZaloPay deep link format
    final zalopayUrl = Uri.parse('zalopay://app');

    // Alternative web URL
    final zalopayWebUrl = Uri.parse('https://zalopay.vn');

    try {
      if (await canLaunchUrl(zalopayUrl)) {
        await launchUrl(zalopayUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to web if app not installed
        if (await canLaunchUrl(zalopayWebUrl)) {
          await launchUrl(zalopayWebUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not open ZaloPay';
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(
          'ZaloPay app is not installed. Please install it first.',
        );
      }
    }
  }

  Future<void> _openBankingQr() async {
    // For Banking QR, you might want to show a dialog with QR code
    // or navigate to a screen that displays the QR code
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Banking QR Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.qr_code_2, size: 200),
              const SizedBox(height: 16),
              Text(
                'Scan this QR code with your banking app',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Amount: ${widget.plan.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodOption {
  final PaymentMethod method;
  final String name;
  final String description;
  final String logoPath;
  final Color color;

  PaymentMethodOption({
    required this.method,
    required this.name,
    required this.description,
    required this.logoPath,
    required this.color,
  });
}
