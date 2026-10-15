-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_is_status_flag
-- Type: INDEX

-- Name: ix_is_status_flag; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_is_status_flag ON dd.dd_product_cart_paydetails USING btree (is_status_flag);


--
