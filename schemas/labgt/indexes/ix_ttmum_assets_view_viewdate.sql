-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labgt.labgt_assets_view USING btree (view_date DESC NULLS LAST);


--
