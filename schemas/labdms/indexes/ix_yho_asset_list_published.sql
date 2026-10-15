-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_yho_asset_list_published
-- Type: INDEX

-- Name: ix_yho_asset_list_published; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_yho_asset_list_published ON labdms.labdms_asset_list USING btree (is_published, is_active, is_deleted);


--
