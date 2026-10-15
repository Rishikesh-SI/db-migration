-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_page_alias
-- Type: INDEX

-- Name: ix_yho_page_alias; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_page_alias ON yho.yho_page USING btree (alias);


--
