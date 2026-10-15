-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_mscc_cc
-- Type: INDEX

-- Name: ix_mscc_cc; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_mscc_cc ON labmi.labmi_membership_coupon_code USING btree (coupon_code);


--
