-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: details_idx
-- Type: INDEX

-- Name: details_idx; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX details_idx ON labrr.labrr_product_cart_details USING btree (product_cart_id, product_customize_map_id);


--
