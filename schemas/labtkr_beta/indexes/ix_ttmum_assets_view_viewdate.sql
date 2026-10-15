-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labtkr_beta.labtkr_assets_view USING btree (view_date DESC NULLS LAST);


--
