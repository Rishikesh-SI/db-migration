-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_pcpd_pcid
-- Type: INDEX

-- Name: ix_pcpd_pcid; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_pcpd_pcid ON labmi_beta_22042024.labmi_product_cart_paydetails USING btree (product_cart_id);


--
