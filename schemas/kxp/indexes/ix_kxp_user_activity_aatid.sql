-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_user_activity_aatid
-- Type: INDEX

-- Name: ix_kxp_user_activity_aatid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_user_activity_aatid ON kxp.kxp_user_activity USING btree (asset_id, asset_type_id);


--
