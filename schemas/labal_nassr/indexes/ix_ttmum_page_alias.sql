-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labal_nassr.labal_nassr_page USING btree (alias);


--
