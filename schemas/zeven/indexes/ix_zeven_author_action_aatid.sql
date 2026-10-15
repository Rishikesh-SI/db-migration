-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_author_action_aatid
-- Type: INDEX

-- Name: ix_zeven_author_action_aatid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_author_action_aatid ON zeven.zeven_author_action USING btree (asset_id, asset_type_id);


--
