-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_user_activity_aatid
-- Type: INDEX

-- Name: ix_hsl_user_activity_aatid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_user_activity_aatid ON hsl.hsl_user_activity USING btree (asset_id, asset_type_id);


--
