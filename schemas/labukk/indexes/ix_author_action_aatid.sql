-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labukk.labukk_author_action USING btree (asset_type_id, asset_id);


--
