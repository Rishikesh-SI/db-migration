-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labkc_v1_02042024.labkc_v1_author_action USING btree (asset_type_id, asset_id);


--
