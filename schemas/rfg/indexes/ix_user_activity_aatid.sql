-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_user_activity_aatid
-- Type: INDEX

-- Name: ix_user_activity_aatid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_user_activity_aatid ON rfg.rfg_user_activity USING btree (asset_id, asset_type_id);


--
