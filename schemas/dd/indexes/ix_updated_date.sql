-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_updated_date
-- Type: INDEX

-- Name: ix_updated_date; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_updated_date ON dd.dd_product_cart_paydetails USING btree (updated_date DESC);


--
