-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labmi.labmi_author_action USING btree (asset_type_id, asset_id);


--
