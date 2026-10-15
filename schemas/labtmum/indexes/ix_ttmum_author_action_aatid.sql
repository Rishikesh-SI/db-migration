-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_author_action_aatid
-- Type: INDEX

-- Name: ix_ttmum_author_action_aatid; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_author_action_aatid ON labtmum.labtmum_author_action USING btree (asset_id, asset_type_id);


--
