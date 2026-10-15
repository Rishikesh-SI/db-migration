-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zvn_review_userid_idx
-- Type: INDEX

-- Name: zvn_review_userid_idx; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zvn_review_userid_idx ON zeven.zeven_comment_review USING btree (user_id, venue_masterid, is_published);


--
