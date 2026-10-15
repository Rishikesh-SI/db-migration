-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labpvl.labpvl_author_action USING btree (asset_type_id, asset_id);


--
