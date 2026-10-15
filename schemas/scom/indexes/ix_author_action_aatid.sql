-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_author_action_aatid ON scom.scom_author_action USING btree (asset_id, asset_type_id);


--
