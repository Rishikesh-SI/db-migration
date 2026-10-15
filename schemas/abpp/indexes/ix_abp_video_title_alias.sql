-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_video_title_alias
-- Type: INDEX

-- Name: ix_abp_video_title_alias; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_video_title_alias ON abpp.abp_video USING btree (upper(title_alias));


--
