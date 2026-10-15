-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labman.labman_assets_view USING btree (view_date DESC NULLS LAST);


--
