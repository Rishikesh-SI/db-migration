-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON isl.isl_assets_view USING btree (view_date DESC NULLS LAST);


--
