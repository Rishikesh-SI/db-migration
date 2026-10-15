-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_mscc_ug
-- Type: INDEX

-- Name: ix_mscc_ug; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_mscc_ug ON labmi_v1.labmi_v1_membership_coupon_code USING btree (user_guid);


--
