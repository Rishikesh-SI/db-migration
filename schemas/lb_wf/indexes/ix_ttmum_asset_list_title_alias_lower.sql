-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON lb_wf.lb_wf_asset_list USING btree (lower((title_alias)::text));


--
