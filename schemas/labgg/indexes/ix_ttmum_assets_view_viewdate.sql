-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labgg.labgg_assets_view USING btree (view_date DESC NULLS LAST);


--
