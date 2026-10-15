-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_pc_ug
-- Type: INDEX

-- Name: ix_pc_ug; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_pc_ug ON labmi_beta_22042024.labmi_product_cart USING btree (user_guid);


--
