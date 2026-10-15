-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_updated_date
-- Type: INDEX

-- Name: ix_updated_date; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_updated_date ON labmi_v1.labmi_v1_product_cart_paydetails USING btree (updated_date DESC);


--
