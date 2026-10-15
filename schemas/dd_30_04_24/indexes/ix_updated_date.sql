-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_updated_date
-- Type: INDEX

-- Name: ix_updated_date; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_updated_date ON dd_30_04_24.dd_product_cart_paydetails USING btree (updated_date DESC);


--
