-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_pcpd_ug
-- Type: INDEX

-- Name: ix_pcpd_ug; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_pcpd_ug ON labmi_beta_22042024.labmi_product_cart_paydetails USING btree (user_guid);


--
