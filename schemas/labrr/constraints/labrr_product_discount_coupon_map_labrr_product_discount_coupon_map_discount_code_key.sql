-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_discount_coupon_map labrr_product_discount_coupon_map_discount_code_key
-- Type: CONSTRAINT

-- Name: labrr_product_discount_coupon_map labrr_product_discount_coupon_map_discount_code_key; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_product_discount_coupon_map
    ADD CONSTRAINT labrr_product_discount_coupon_map_discount_code_key UNIQUE (discount_code);


--
