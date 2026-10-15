-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_user_activity_aatid
-- Type: INDEX

-- Name: ix_pbl_user_activity_aatid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_user_activity_aatid ON pbl.pbl_user_activity USING btree (asset_id, asset_type_id);


--
