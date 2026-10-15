-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_page_alias
-- Type: INDEX

-- Name: ix_dd_page_alias; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_page_alias ON dd_30_04_24.dd_page USING btree (alias);


--
