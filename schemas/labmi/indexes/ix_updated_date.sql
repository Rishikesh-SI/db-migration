-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_updated_date
-- Type: INDEX

-- Name: ix_updated_date; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_updated_date ON labmi.labmi_product_cart_paydetails USING btree (updated_date DESC);


--
