-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labgt_bkp.labgt_assets_view USING btree (view_date DESC NULLS LAST);


--
