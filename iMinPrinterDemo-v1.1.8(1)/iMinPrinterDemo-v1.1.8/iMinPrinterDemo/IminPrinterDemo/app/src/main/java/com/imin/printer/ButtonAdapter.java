package com.imin.printer;

import android.content.Context;
import android.content.res.Configuration;
import android.view.View;
import android.widget.Button;

import java.util.List;

import androidx.recyclerview.widget.RecyclerView;


public class ButtonAdapter extends BaseRecyclerAdapter<String> {
    private Button bt_item;
    private OnClickListener onClickListener;
    private int itemHeight, itemWidth, intervalPx;


    public ButtonAdapter(List<String> data, Context context) {
        super(data);
//        if (context.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
//            itemWidth = dp2px(context, 200);
//            itemHeight = dp2px(context, 100);
//            intervalPx = dp2px(context, 20);
//        } else {
//            itemWidth = dp2px(context, 270);
//            itemHeight = dp2px(context, 100);
//            intervalPx = dp2px(context, 30);
//        }
    }

    @Override
    protected int getLayoutResId(int position) {
        return R.layout.item_print_button;
    }

    @Override
    protected void bindContent(BaseViewHolder holder, final int i) {
        View itemView = holder.itemView;
//        RecyclerView.LayoutParams lp = (RecyclerView.LayoutParams) itemView.getLayoutParams();
//        lp.width = itemWidth;
//        lp.height = itemHeight;
//        lp.bottomMargin = intervalPx;
        bt_item = itemView.findViewById(R.id.bt_item);
        bt_item.setText(data.get(i));
        bt_item.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (onClickListener != null) {
                    onClickListener.onClick(v, i, data.get(i));
                }
            }
        });


    }

    public void setOnClickListener(OnClickListener onClickListener) {
        this.onClickListener = onClickListener;
    }

    public int dp2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

}
