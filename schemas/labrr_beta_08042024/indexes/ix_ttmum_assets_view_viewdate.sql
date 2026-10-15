-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labrr_beta_08042024.labrr_assets_view USING btree (view_date DESC NULLS LAST);


--
