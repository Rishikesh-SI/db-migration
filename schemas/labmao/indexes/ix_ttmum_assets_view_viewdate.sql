-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labmao.labmao_assets_view USING btree (view_date DESC NULLS LAST);


--
