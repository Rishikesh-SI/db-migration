-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labsrk.labsrk_assets_view USING btree (view_date DESC NULLS LAST);


--
