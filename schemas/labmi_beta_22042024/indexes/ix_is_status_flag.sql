-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_is_status_flag
-- Type: INDEX

-- Name: ix_is_status_flag; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_is_status_flag ON labmi_beta_22042024.labmi_product_cart_paydetails USING btree (is_status_flag);


--
