-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_updated_date
-- Type: INDEX

-- Name: ix_updated_date; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_updated_date ON labmi_beta_22042024.labmi_product_cart_paydetails USING btree (updated_date DESC);


--
