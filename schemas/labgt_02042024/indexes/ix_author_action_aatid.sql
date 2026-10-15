-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labgt_02042024.labgt_author_action USING btree (asset_type_id, asset_id);


--
