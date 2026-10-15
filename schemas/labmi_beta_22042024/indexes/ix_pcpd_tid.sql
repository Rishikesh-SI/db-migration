-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_pcpd_tid
-- Type: INDEX

-- Name: ix_pcpd_tid; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_pcpd_tid ON labmi_beta_22042024.labmi_product_cart_paydetails USING btree (tracking_id);


--
