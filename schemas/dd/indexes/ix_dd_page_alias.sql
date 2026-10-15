-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_page_alias
-- Type: INDEX

-- Name: ix_dd_page_alias; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_page_alias ON dd.dd_page USING btree (alias);


--
