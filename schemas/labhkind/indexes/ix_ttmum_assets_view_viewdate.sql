-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labhkind.labhkind_assets_view USING btree (view_date DESC NULLS LAST);


--
