-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_mscc_ug
-- Type: INDEX

-- Name: ix_mscc_ug; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_mscc_ug ON labmi_beta_22042024.labmi_membership_coupon_code USING btree (user_guid);


--
