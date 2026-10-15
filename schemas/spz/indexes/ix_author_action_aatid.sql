-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_author_action_aatid ON spz.spz_author_action USING btree (asset_id, asset_type_id);


--
