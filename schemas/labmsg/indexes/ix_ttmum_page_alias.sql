-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labmsg; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labmsg.labmsg_page USING btree (alias);


--
