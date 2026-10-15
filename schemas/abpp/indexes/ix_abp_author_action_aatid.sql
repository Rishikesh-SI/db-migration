-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_author_action_aatid
-- Type: INDEX

-- Name: ix_abp_author_action_aatid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_author_action_aatid ON abpp.abp_author_action USING btree (asset_id, asset_type_id);


--
