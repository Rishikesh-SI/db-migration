-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_assets_view_view_date_idx
-- Type: INDEX

-- Name: labbsc_dev_assets_view_view_date_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE INDEX labbsc_dev_assets_view_view_date_idx ON labbsc_dev.labbsc_dev_assets_view USING btree (view_date DESC NULLS LAST);


--
