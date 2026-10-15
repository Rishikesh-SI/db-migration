-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: idx_asset_id_status
-- Type: INDEX

-- Name: idx_asset_id_status; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX idx_asset_id_status ON labwis.labwis_asset_draft USING btree (asset_id, (((asset_data -> 'data'::text) ->> 'status'::text)));


--
