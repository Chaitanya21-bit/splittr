part of 'quick_split_page.dart';

class _QuickSplitForm extends StatelessWidget {
  const _QuickSplitForm();

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      heightFactor: 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              'Add Name & Amount',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 33),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 75,
                  height: 31,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_box,
                        color: AppColors.blackColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Add',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return QuickSplitInputCard(
                  onDelete: () {},
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 325,
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.blueButtonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: Text(
                'Check Split',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
