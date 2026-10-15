-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_uniq_title_alias
-- Type: INDEX

-- Name: ix_uniq_title_alias; Type: INDEX; Schema: labdms; Owner: -
--

CREATE UNIQUE INDEX ix_uniq_title_alias ON labdms.labdms_article USING btree (lower((title_alias)::text)) WHERE (is_published = (1)::numeric);


--
